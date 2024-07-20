module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,  // Initial state
        B = 3'b001,  // Output f = 1 state
        C = 3'b010,  // Monitor x for 1
        D = 3'b011,  // Monitor x for 0
        E = 3'b100,  // Monitor x for 1 again
        F = 3'b101,  // Set g = 1; Monitor y
        G = 3'b110,  // Maintain g = 1 state
        H = 3'b111   // Set g = 0 state
    } state_t;

    state_t current_state, next_state;
    reg [1:0] y_counter;

    // Synchronous state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = current_state;
        f = 0;
        g = 0;
        case (current_state)
            A: begin
                if (resetn)
                    next_state = B;
            end
            B: begin
                f = 1;
                next_state = C;
            end
            C: begin
                f = 0;
                if (x) next_state = D;
            end
            D: begin
                if (!x) next_state = E;
            end
            E: begin
                if (x) next_state = F;
            end
            F: begin
                g = 1;
                if (y) next_state = G;
                else begin
                    if (y_counter == 2) next_state = H;
                    else y_counter = y_counter + 1;
                end
            end
            G: begin
                g = 1;
            end
            H: begin
                g = 0;
            end
        endcase
    end

    // Counter reset logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            y_counter <= 2'b00;
        else if (current_state != F)
            y_counter <= 2'b00;
    end

endmodule
