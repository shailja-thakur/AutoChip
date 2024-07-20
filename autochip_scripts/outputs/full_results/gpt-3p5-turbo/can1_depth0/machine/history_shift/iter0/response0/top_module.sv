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


// Variables to store current state
reg [31:0] state_predict_history;

always@(posedge clk or posedge train_mispredicted) begin
    if (areset) begin
        state_predict_history <= 0;
    end else begin
        if (train_mispredicted) begin
            state_predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            state_predict_history <= {state_predict_history[30:0], predict_taken};
        end
    end
end

assign predict_history = state_predict_history;

endmodule
