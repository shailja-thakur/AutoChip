module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out;

// State encoding
parameter B = 2'b00; // State B
parameter A = 2'b01; // State A

// Next state logic
always @(posedge clk, negedge areset) begin
    if (areset)
        state <= B;
    else begin
        case(state)
            B: begin
                if (in)
                    state <= B;
                else
                    state <= A;
            end
            A: begin
                if (in)
                    state <= A;
                else
                    state <= B;
            end
            default: state <= B;
        endcase
    end
end

// Output logic
always @(state) begin
    case(state)
        B: out = 1;
        A: out = 0;
        default: out = 1;
    endcase
end

endmodule
