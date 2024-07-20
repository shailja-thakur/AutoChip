module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define states
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    // Define current and next state registers
    reg [2:0] curr_state;
    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            curr_state <= A;
        end 
        else begin
            curr_state <= next_state;
        end
    end

    always @* begin
        case(curr_state)
            A: begin
                if(w == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if(w == 1'b1)
                    next_state = D;
                else
                    next_state = C;
            end
            C: begin
                if(w == 1'b1)
                    next_state = D;
                else
                    next_state = E;
            end
            D: begin
                if(w == 1'b1)
                    next_state = A;
                else
                    next_state = F;
            end
            E: begin
                if(w == 1'b1)
                    next_state = D;
                else
                    next_state = E;
            end
            F: begin
                if(w == 1'b1)
                    next_state = D;
                else
                    next_state = C;
            end
        endcase
    end

    always @* begin
        if(curr_state == E || curr_state == F)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
