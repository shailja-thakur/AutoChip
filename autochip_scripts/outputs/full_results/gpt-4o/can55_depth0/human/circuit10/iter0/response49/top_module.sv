module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// State definitions
parameter S0 = 1'b0;
parameter S1 = 1'b1;

// Sequential logic for state and output
always @(posedge clk) begin
    case (state)
        S0: begin
            if (a & b) begin
                state <= S0;
                q <= 0;
            end else if (a & ~b) begin
                state <= S1;
                q <= 1;
            end else begin
                state <= S0;
                q <= q;
            end
        end
        
        S1: begin
            if (a & b) begin
                state <= S1;
                q <= 1;
            end else if (a & ~b) begin
                state <= S0;
                q <= 0;
            end else begin
                state <= S1;
                q <= q;
            end
        end
        
        default: begin
            state <= S0;
            q <= 0;
        end
    endcase
end

// Initial state
initial begin
    state = S0;
    q = 0;
end

endmodule
