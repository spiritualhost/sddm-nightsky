import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Particles 2.0

//At each launch of the script, choose a series of random points around the screen, creating "stars" represented by "•"
//They will randomly flicker, becoming "*"

Item {

    //Place in background, behind UI elements
    z: 0

    //Creates a particle system container, with all Emitter and Particle items using this system
    ParticleSystem {
        id: system
        anchors.fill: parent
    }

    //Responsible for generating particles
    //Configure emission properties here: rate, shape, velocity, angle, life span, size, color, etc.
    Emitter {
        id: starshine
        system: system
        lifespan: 2000 //static until flicker
        lifeSpanVariation: 0
        width: parent.width
        height: parent.height
        emitRate: 100
        velocity: 0 //keeps stars in place
    }

    TextParticle {
        system: system
        text: "*"
        color: "yellow"
        font.pixelSize: 12
        sizeVariation: 5

        fade: 1000
        fadeVariation: 800

        //flicker using opacity
        alphaVariation: 1.0 //allows opacity to vary from 0 to 1
    }
}
