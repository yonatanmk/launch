beforeEach(() => {
  jasmine.addMatchers({
    toBeAnagram: () => {
      return {
        compare: (actual) => { // commonly (actual, expected)
          return {
            pass: actual === actual.split("").reverse().join("")
          };
        }
      };
    }
  });
});
