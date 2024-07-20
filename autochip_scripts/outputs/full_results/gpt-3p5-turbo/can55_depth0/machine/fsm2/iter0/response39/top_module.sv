module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    reg current_state, next_state;
      
    always @ (posedge clk) begin
        if (areset) begin
            current_state <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @ (*) begin
        if (current_state) begin
            if (j) begin
                next_state = 1'b1;
            end else begin
                next_state = 1'b0;
            end
        end else begin
            if (k) begin
                next_state = 1'b0;
            end else begin
                next_state = 1'b1;
            end
        end
    end
    
    assign out = current_state;
    
endmodule
