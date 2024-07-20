module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State encoding
localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// State registers
reg [2:0] current_state, next_state;

// State table
always @(*) begin
    case (current_state)
        A: begin
            if (w) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = D;
            end
        end
        C: begin
            if (w) begin
                next_state = E;
            end else begin
                next_state = D;
            end
        end
        D: begin
            if (w) begin
                next_state = F;
            end else begin
                next_state = A;
            end
        end
        E: begin
            if (w) begin
                next_state = E;
            end else begin
                next_state = D;
            end
        end
        F: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = D;
            end
        end
        default: next_state = A;
    endcase
end

// State flip-flops
always @(posedge clk) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Output logic
always @(*) begin
    case (current_state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
