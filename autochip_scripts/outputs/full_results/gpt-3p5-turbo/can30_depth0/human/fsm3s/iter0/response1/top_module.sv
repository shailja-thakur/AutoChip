module top_module(
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
wire [1:0] next_state;
reg out_reg;

// State definitions
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Output definitions
assign out = out_reg;

// State transition and output logic
always @(posedge clk) begin
    if (reset) begin
        state <= A;
        out_reg <= 0;
    end else begin
        state <= next_state;
        case (state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out_reg = 0;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out_reg = 0;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
                out_reg = 0;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out_reg = 1;
            end
        endcase
    end
end

endmodule
