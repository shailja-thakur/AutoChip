module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] current_state, next_state;
    reg out_reg;

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            out_reg <= 0;
        end 
        else begin
            current_state <= next_state;
            out_reg <= (current_state == D) ? 1 : 0;
        end
    end

    always @(current_state, in) begin
        case (current_state)
            A: if (in) next_state <= B; else next_state <= A;
            B: if (in) next_state <= B; else next_state <= C;
            C: if (in) next_state <= D; else next_state <= A;
            D: if (in) next_state <= B; else next_state <= C;
            default: next_state <= A;
        endcase
    end

    assign out = out_reg;

endmodule
