module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000, // Initial state
        B = 3'b001, // Output f = 1 for one cycle
        C = 3'b010, // Wait for x = 1, 0, 1 pattern
        D = 3'b011, // Output g = 1, check y
        E = 3'b100, // Wait 1 more cycle for y
        F = 3'b101, // Permanently set g = 1
        G = 3'b110  // Permanently set g = 0
    } state_t;
    
    state_t state, next_state;
    reg [1:0] counter; // Counter for the y input condition
    
    // Sequential logic for state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Sequential logic for the counter
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            counter <= 2'b00;
        else if (state == D || state == E)
            counter <= counter + 1;
        else
            counter <= 2'b00;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default outputs
        f = 1'b0;
        g = 1'b0;
        next_state = state;
        
        case (state)
            A: begin
                if (!resetn)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                f = 1'b1;
                next_state = C;
            end
            C: begin
                if (x == 1'b1 && $past(x, 1) == 1'b0 && $past(x, 2) == 1'b1)
                    next_state = D;
                else
                    next_state = C;
            end
            D: begin
                g = 1'b1;
                if (y == 1'b1)
                    next_state = F;
                else if (counter == 2'b01)
                    next_state = E;
            end
            E: begin
                g = 1'b1;
                if (y == 1'b1)
                    next_state = F;
                else
                    next_state = G;
            end
            F: begin
                g = 1'b1;
                next_state = F; // Permanently set g to 1
            end
            G: begin
                g = 1'b0;
                next_state = G; // Permanently set g to 0
            end
            default: next_state = A;
        endcase
    end

endmodule
