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

    reg [31:0] global_history;
    reg flush_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            flush_state <= 0;
        end
        else begin
            if (flush_state) begin
                global_history <= {train_history, train_taken};
                flush_state <= 0;
            end
            else if (predict_valid) begin
                global_history <= {global_history[30:0], predict_taken};
            end
            else if (train_mispredicted) begin
                global_history <= global_history;
                flush_state <= 1;
            end
        end
    end
    
    assign predict_history = global_history;
    
endmodule
