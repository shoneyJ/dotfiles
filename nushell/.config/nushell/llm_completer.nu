def llm_completer [spans: list<string>] {
    let host = "http://127.0.0.1:8080"

    let body = {
        max_tokens: 150,
        prompt: $"You are a concise code/command-completion assistant. The user typed: '($spans | str join ' ')'.\nReturn only the completion/continuation. \n Explaination is not required",
        repeat_last_n: 64,
        repeat_penalty: 1.2,
        stop: ["\n\n", "//", "#"],
        stream: false,
        temperature: 0.0,
        top_k: 40,
        top_p: 0.95
    }

  let response =     http post $"($host)/completion" ($body | to json)

   ($response.content | lines | where $it != "") 
    | each { |x| { value: $x, description: "LLM completion" } }
}

