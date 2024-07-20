module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end

    // State table
    always @(*) begin
        next_state = current_state;  // Default to current state
        case (current_state)
            A: begin
                if (r[1] == 1) next_state = B;
                else if (r[2] == 1) next_state = C;
                else if (r[3] == 1) next_state = D;
                else next_state = A;
            end
            B: begin
                if (r[1] == 1) next_state = B;
                else next_state = A;
            end
            C: begin
                if (r[2] == 1) next_state = C;
                else next_state = A;
            end
            D: begin
                next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default outputs
        g = 3'b000;
        case (current_state)
            A: g = 3'b000;
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end
endmodule
