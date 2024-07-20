module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    // Internal signals
    reg [31:0] shift_register;

    // Positive edge triggered asynchronous reset
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            shift_register <= 0;
        else
        begin
            if (train_mispredicted)
                shift_register <= {train_history, train_taken};
            else if (predict_valid)
                shift_register <= {shift_register[30:0], predict_taken};
        end
    end

    // Assign predict_history the value of the branch history register
    assign predict_history = shift_register;

endmodule
