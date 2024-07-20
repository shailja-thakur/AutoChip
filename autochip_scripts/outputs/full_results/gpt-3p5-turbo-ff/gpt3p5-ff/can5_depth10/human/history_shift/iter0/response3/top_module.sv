module top_module(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    logic [31:0] global_history;         // 32-bit global history shift register
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            global_history <= 0;
        else if (train_mispredicted)
            global_history <= {train_history[30:0], train_taken};    // Concatenate train_history with train_taken
        else if (predict_valid)
            global_history <= {predict_history[30:0], predict_taken};    // Shift in predict_taken from LSB side
    end

    assign predict_history = global_history;    // Output predict_history
    
endmodule
