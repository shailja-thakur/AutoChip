module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    parameter STATE_A = 2'b00;
    parameter STATE_B = 2'b01;
    parameter STATE_C = 2'b10;
    parameter STATE_D = 2'b11;

    reg [1:0] current_state, next_state;

    always@(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end
        else begin
            current_state <= next_state;
        end
    end

    always@(current_state, in) begin
        case (current_state)
            STATE_A: begin
                if(in)
                    next_state <= STATE_B;
                else
                    next_state <= STATE_A;
            end
            STATE_B: begin
                if(in)
                    next_state <= STATE_B;
                else
                    next_state <= STATE_C;
            end
            STATE_C: begin
                if(in)
                    next_state <= STATE_D;
                else
                    next_state <= STATE_A;
            end
            STATE_D: begin
                if(in)
                    next_state <= STATE_B;
                else
                    next_state <= STATE_C;
            end
            default: next_state <= STATE_A;
        endcase
    end

    always@(current_state) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
