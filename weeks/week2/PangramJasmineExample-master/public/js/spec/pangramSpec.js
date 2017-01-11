describe('isPangram', () => {
  it('returns true if the sentence is a pangram', () => {
    let sentence = "The quick brown fox jumps over the lazy dog.";
    expect(isPangram(sentence)).toBe(true);
  });
  it('returns false if the sentence is not a pangram', () => {
    let sentence = "Hi Mom!";
    expect(isPangram(sentence)).toBe(false);
  });
});
describe('toBeAnagramHelper', () => {
  it('works', () => {
    expect("lol").toBeAnagram();
  })
})
