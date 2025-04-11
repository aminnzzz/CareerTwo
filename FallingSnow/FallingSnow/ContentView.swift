//
//  ContentView.swift
//  FallingSnow
//
//  Created by amin nazemzadeh on 4/11/25.
//

import SwiftUI

class Particle {
    var x: Double
    var y: Double
    let xSpeed: Double
    let ySpeed: Double
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 3

    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}

class ParticleSystem {
    var particles = [Particle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate

    func update(date: TimeInterval, size: CGSize) {
        let delta = date - lastUpdate
        lastUpdate = date

        for (index, particle) in particles.enumerated() {
            if particle.deathDate < date {
                particles.remove(at: index)
            } else {
                particle.x += particle.xSpeed * delta
                particle.y += particle.ySpeed * delta
            }
        }

        let newParticle = Particle(x: .random(in: -16...size.width), y: -16, xSpeed: .random(in: -50...50), ySpeed: .random(in: 100...250))
        particles.append(newParticle)
    }
}

struct ContentView: View {
    @State private var particleSystem = ParticleSystem()

    var body: some View {
        LinearGradient(colors: [.red, .pink], startPoint: .top, endPoint: .bottom).mask {

            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate, size: size)
                    ctx.addFilter(.blur(radius: 5))
                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))

                    ctx.drawLayer { ctx in
                        for particle in particleSystem.particles {
                            ctx.opacity = particle.deathDate - timelineDate
                            ctx.fill(Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 16, height: 16)), with: .color(.white))
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    ContentView()
}
