// Starting data
let notes = [
  { id: 1, text: "Buy milk and bread", category: "personal" },
  { id: 2, text: "Finish the Day 3 assignment", category: "study" },
  { id: 3, text: "Email the project report to Grace", category: "work" },
  { id: 4, text: "Revise JavaScript arrays", category: "study" },
  { id: 5, text: "Call mum", category: "personal" },
];

// 1. searchNotes(word)
function searchNotes(word) {
  const searchTerm = word.toLowerCase();
  return notes.filter((note) => note.text.toLowerCase().includes(searchTerm));
}

// 2. longestNote()
function longestNote() {
  if (notes.length === 0) {
    return null;
  }
  return notes.reduce((longest, current) => {
    return current.text.length > longest.text.length ? current : longest;
  }, notes[0]);
}

// 3. countByCategory()
function countByCategory() {
  const counts = {};
  for (const note of notes) {
    counts[note.category] = (counts[note.category] || 0) + 1;
  }
  return counts;
}

// 4. getSummary()
function getSummary() {
  const total = notes.length;
  const wordNote = total === 1 ? "note" : "notes";
  const counts = countByCategory();

  const parts = [];
  for (const category in counts) {
    parts.push(`${counts[category]} ${category}`);
  }

  return `${total} ${wordNote}: ${parts.join(", ")}.`;
}

// 5. isDuplicate(text)
function isDuplicate(text) {
  const formattedInput = text.trim().toLowerCase();
  return notes.some(
    (note) => note.text.trim().toLowerCase() === formattedInput
  );
}

// 6. addNote(text, category)
function addNote(text, category) {
  const validCategories = ["personal", "work", "study"];
  const trimmedText = text.trim();

  if (trimmedText.length < 1 || trimmedText.length > 200) {
    console.log("Failed to add note: Text length must be between 1 and 200 characters.");
    return false;
  }

  if (!validCategories.includes(category)) {
    console.log(`Failed to add note: Invalid category "${category}". Must be personal, work, or study.`);
    return false;
  }

  if (isDuplicate(trimmedText)) {
    console.log("Failed to add note: A note with this text already exists.");
    return false;
  }

  const newNote = {
    id: notes.length > 0 ? Math.max(...notes.map((n) => n.id)) + 1 : 1,
    text: trimmedText,
    category: category,
  };

  notes.push(newNote);
  return true;
}

// ==========================================
// TESTING THE FUNCTIONS
// ==========================================

console.log("--- 1. Testing searchNotes ---");
console.log(searchNotes("REPORT")); 
// Expected: [{ id: 3, text: "Email the project report to Grace", category: "work" }]

console.log(searchNotes("python")); 
// Expected: []

console.log("--- 2. Testing longestNote ---");
console.log(longestNote()); 
// Expected: { id: 3, text: "Email the project report to Grace", category: "work" }

// Edge case: Empty notes array
const tempNotes = notes;
notes = [];
console.log(longestNote()); 
// Expected: null
notes = tempNotes; // Restore notes array

console.log("--- 3. Testing countByCategory ---");
console.log(countByCategory()); 
// Expected: { personal: 2, study: 2, work: 1 }

console.log("--- 4. Testing getSummary ---");
console.log(getSummary()); 
// Expected: "5 notes: 2 personal, 2 study, 1 work."

// Edge case: Singular "note" with 1 item
notes = [{ id: 1, text: "Single item", category: "personal" }];
console.log(getSummary()); 
// Expected: "1 note: 1 personal."
notes = tempNotes; // Restore notes array

console.log("--- 5. Testing isDuplicate ---");
console.log(isDuplicate("  CALL MUM  ")); 
// Expected: true

console.log(isDuplicate("Buy fresh fruit")); 
// Expected: false

console.log("--- 6. Testing addNote ---");
console.log(addNote("Read a book chapter", "study")); 
// Expected: true (Logs no error)

console.log(addNote("Call mum", "personal")); 
// Expected: false (Logs: "Failed to add note: A note with this text already exists.")

console.log(addNote("   ", "personal")); 
// Expected: false (Logs: "Failed to add note: Text length must be between 1 and 200 characters.")

console.log(addNote("New Gym Plan", "fitness")); 
// Expected: false (Logs: "Failed to add note: Invalid category "fitness". Must be personal, work, or study.")