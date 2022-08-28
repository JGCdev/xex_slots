// POSITIONS
// 0 - Any
// 1 - Figure number 1
// 2 - Figure number 2
// 3 - Figure number 3
// 4 - Figure number 4
// 5 - Figure number 5
// 6 - Figure number 6
// 7 - Figure number 7

var config = {
    tripleMultipliers: [1,1.1,1.2,1.3,1.4,1.5,1.6,1.7],
    cuadrupleMultipliers: [1,1.8,1.9,2,2.1,2.2,2.3,2.4],
    quintupleMultipliers: [1,2.5,2.6,2.7,2.8,2.9,3,4],
    betCap: 300, // Bet limit
    maxDoubleCap: 700, // Limit to double bets
    language: 'en' // language from languages array
};

var languages = {
    en: {
        red: 'RED',
        black: 'BLACK',
        take_money: 'TAKE MONEY',
        more_bet: '+ BET',
        allin: 'ALLIN',
        roll: 'ROLL',
        target1: 'YOU WON',
        target2: '$',
        target3: '! - ¿Double?',
        target4: 'Credits:',
        target5: '$',
        target6: 'Bet: ',
        target7: '$',
        target8: 'History:',
        target9: '+BET',
        target10: 'ALL IN',
        target11: 'ROLL',
        target12: 'Sound effects',
    },
    es: {
      red: 'ROJO',
      black: 'NEGRO',
      take_money: 'RECOGER GANANCIA',
      more_bet: '+ BET',
      allin: 'ALLIN',
      roll: 'ROLL',
      target1: '¡GANAS',
      target2: '$',
      target3: '! - ¿Doblas?',
      target4: 'Créditos:',
      target5: '$',
      target6: 'Apuesta: ',
      target7: '$',
      target8: 'Historial:',
      target9: '+BET',
      target10: 'ALL IN',
      target11: 'GIRAR',
      target12: 'Efectos de sonido',
    },
};


