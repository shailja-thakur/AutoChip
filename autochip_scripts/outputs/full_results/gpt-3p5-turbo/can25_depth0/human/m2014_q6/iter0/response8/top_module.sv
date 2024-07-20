module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State Encoding
    parameter [2:0] A = 3'b000;
    parameter [2:0] B = 3'b001;
    parameter [2:0] C = 3'b010;
    parameter [2:0] D = 3'b011;
    parameter [2:0] E = 3'b100;
    parameter [2:0] F = 3'b101;

    // State Register
    reg [2:0] current_state, next_state;

    // Output Register
    reg [2:0] output_register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            output_register <= 3'b000;
        end else begin
            current_state <= next_state;
            output_register <= {output_register[1:0], w};
        end
    end

    always @(*) begin
        case (current_state)
            A: begin
                if (w == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w == 1'b0)
                    next_state = C;
                else
                    next_state = D;
            end
            C: begin
                if (w == 1'b0)
                    next_state = E;
                else
                    next_state = D;
            end
            D: begin
                if (w == 1'b0)
                    next_state = F;
                else
                    next_state = A;
            end
            E: begin
                if (w == 1'b0)
                    next_state = E;
                else
                    next_state = D;
            end
            F: begin
                if (w == 1'b0)
                    next_state = C;
                else
                    next_state = D;
            end
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            z <= 1'b0;
        else
            z <= (current_state == E || current_state == F) ? 1'b1 : 1'b0;
    end

endmodule
