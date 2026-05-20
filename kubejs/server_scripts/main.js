// Visit the wiki for more info - https://kubejs.com/
console.info('Hello, World! (Loaded server example script)')

/* 
 * ServerEvents.recipes(callback) is a function that accepts another function,
 * called the "callback", as a parameter. The callback gets run when the 
 * server is working on recipes, and then we can make our own changes.
 * When the callback runs, it is also known as the event "firing". 
*/

// Listen for the "recipes" server event.
ServerEvents.recipes(event => {
  // You can replace `event` with any name you like, as
  // long as you change it inside the callback too!

  // This part, inside the curly braces, is the callback.
  // You can modify as many recipes as you like in here,
  // without needing to use ServerEvents.recipes() again.
    event.shaped(
      Item.of('minecraft:ladder', 4), // arg 1: output
      [
        'A A',
        'ABA', // arg 2: the shape (array of strings)
        'A A'
      ],
      {
        A: 'minecraft:stick',
        B: '#minecraft:planks',  //arg 3: the mapping object
      }
    )

    event.shaped(
      Item.of('minecraft:chest', 1), // arg 1: output
      [
        'AAA',
        'A A', // arg 2: the shape (array of strings)
        'AAA'
      ],
      {
        A: '#minecraft:planks',
      }
    )

  console.log('Hello! The recipe event has fired!')
})