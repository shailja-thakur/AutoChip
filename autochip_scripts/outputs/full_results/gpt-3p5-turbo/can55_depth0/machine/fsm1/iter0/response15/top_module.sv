module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg state;
    wire next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b0;  // reset state to B
        end else begin
            state <= next_state;  // update state on rising edge of clk
        end
    end
    
    assign out = (state == 1'b1) ? 1'b0 : 1'b1;  // out is high when state is B, low otherwise
    
    always @(state, in) begin
        if (state == 1'b0) begin              // state is A
            if (in) begin
                next_state = 1'b0;            // stay in A if in is high
            end else begin
                next_state = 1'b1;            // transition to B if in is low
            end
        end else begin                       // state is B
            if (in) begin
                next_state = 1'b1;            // stay in B if in is high
            end else begin
                next_state = 1'b0;            // transition to A if in is low
            end
        end
    end
    
endmodule
