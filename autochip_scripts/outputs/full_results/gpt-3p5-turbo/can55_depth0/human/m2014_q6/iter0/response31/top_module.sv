module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    parameter E = 2'b100;
    parameter F = 2'b101;

    reg [2:0] current_state;
    reg [2:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always @* begin
        case (current_state)
            A: begin
                if (w)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
            C: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            D: begin
                if (w)
                    next_state = A;
                else
                    next_state = F;
            end
            E: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            F: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
        endcase
    end

    always @(posedge clk) begin
        case (current_state)
            A: z <= 0;
            B: z <= 0;
            C: z <= 0;
            D: z <= 0;
            E: z <= 1;
            F: z <= 1;
        endcase
    end

endmodule
