module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] current_state, next_state;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk) begin
    if(reset) begin
        current_state <= B;
        out <= 1;
    end else begin
        current_state <= next_state;
        case(current_state)
            B: begin
                if(in)
                    next_state <= B;
                else
                    next_state <= A;
            end
            A: begin
                if(in)
                    next_state <= A;
                else
                    next_state <= B;
            end
            default: next_state <= B;
        endcase
    end
end

always @(*) begin
    case(current_state)
        B: out = 1;
        A: out = 0;
        default: out = 1;
    endcase
end

endmodule
