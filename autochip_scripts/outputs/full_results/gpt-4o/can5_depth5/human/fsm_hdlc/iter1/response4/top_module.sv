module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0 = 3'b000,  // As if the previous input were 0
        S1 = 3'b001,  // Observed 0
        S2 = 3'b010,  // Observed 01
        S3 = 3'b011,  // Observed 011
        S4 = 3'b100,  // Observed 0111
        S5 = 3'b101,  // Observed 01111
        S6 = 3'b110,  // Observed 011111
        S7 = 3'b111   // Observed 0111111 or error state
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        next_state = current_state;

        case (current_state)
            S0: begin
                if (in) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (in) begin
                    next_state = S2;
                end else begin
                    next_state = S0;
                end
            end
            S2: begin
                if (in) begin
                    next_state = S3;
                end else begin
                    next_state = S0;
                end
            end
            S3: begin
                if (in) begin
                    next_state = S4;
                end else begin
                    next_state = S0;
                end
            end
            S4: begin
                if (in) begin
                    next_state = S5;
                end else begin
                    next_state = S0;
                end
            end
            S5: begin
                if (in) begin
                    next_state = S6;
                end else begin
                    next_state = S0;
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                end else begin
                    disc = 1'b1; // 0111110 detected
                    next_state = S0;
                end
            end
            S7: begin
                if (in) begin
                    err = 1'b1; // 01111111... 7 or more 1s detected
                    next_state = S7;
                end else begin
                    flag = 1'b1; // 01111110 detected
                    next_state = S0;
                end
            end
        endcase
    end
endmodule
