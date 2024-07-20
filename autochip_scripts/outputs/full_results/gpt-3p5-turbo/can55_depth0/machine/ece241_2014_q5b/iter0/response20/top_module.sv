module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state; // state register

    parameter A = 2'b00; // state A
    parameter B = 2'b01; // state B

    always @(posedge clk) begin
        if (areset) begin
            state <= A; // set state to A on reset
        end 
        else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B; // transition to state B if x is 1
                    end 
                    else begin
                        state <= A; // stay in state A if x is 0
                    end
                end
                B: begin
                    state <= B; // stay in state B
                end
                default: begin
                    state <= A; // set default state to A
                end
            endcase
        end
    end

    always @(*) begin
        if ((state == A && x) || (state == B && !x)) begin
            z = 1; // set z to 1 if conditions are met
        end 
        else begin
            z = 0; // set z to 0 otherwise
        end
    end

endmodule
