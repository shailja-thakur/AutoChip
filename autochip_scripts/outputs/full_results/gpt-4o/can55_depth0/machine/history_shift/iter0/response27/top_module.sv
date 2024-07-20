module top_module
(
    input wire clk,
    input wire areset,
    input wire predict_valid,
    input wire predict_taken,
    output reg [31:0] predict_history,
    
    input wire train_mispredicted,
    input wire train_taken,
    input wire [31:0] train_history
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule
