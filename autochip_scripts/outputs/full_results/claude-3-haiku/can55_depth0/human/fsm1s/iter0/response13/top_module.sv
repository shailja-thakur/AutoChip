module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State definitions
localparam A = 1'b0;
localparam B = 1'b1;

// State register
reg state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            A: begin
                if (in)
                    state <= A;
                else
                    state <= B;
                out <= 1'b0;
            end
            B: begin
                if (in)
                    state <= B;
                else
                    state <= A;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
