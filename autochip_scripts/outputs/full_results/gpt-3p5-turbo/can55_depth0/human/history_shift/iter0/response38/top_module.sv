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

reg [31:0] shift_register = 0;
reg [31:0] mispredict_history = 0;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        shift_register <= 0;
    end else begin
        if (train_mispredicted) begin
            shift_register <= {train_history[30:0], train_taken};
            mispredict_history <= shift_register;
        end else if (predict_valid) begin
            shift_register <= {shift_register[30:0], predict_taken};
        end
    end
end

assign predict_history = train_mispredicted ? mispredict_history : shift_register;

endmodule
