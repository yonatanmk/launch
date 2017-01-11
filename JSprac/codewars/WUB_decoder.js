function songDecoder(song){
  let wubs = [];
  for (let i = 1; i < Math.ceil(song.length / 3); i++) {
    wubs.unshift('WUB'.repeat(i));
  }
  for (let wub of wubs) {
    song = song.replace(new RegExp(wub, 'g'),' ');
  }
  return song.trim();
}
