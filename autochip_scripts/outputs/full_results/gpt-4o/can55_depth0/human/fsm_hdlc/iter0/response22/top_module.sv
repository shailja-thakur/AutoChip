module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // 0 observed
        S2, // 01 observed
        S3, // 011 observed
        S4, // 0111 observed
        S5, // 01111 observed
        S6, // 011111 observed
        S7, // Error state
        F   // Flag state
    } state_t;

    state_t current_state, next_state;
    reg [2:0] one_count;

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            current_state <= S0;
            one_count <= 3'b000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (current_state)
            S0: begin
                if (in) begin
                    next_state = S1;
                    one_count = 1;
                end
            end
            S1: begin
                if (in) begin
                    one_count = one_count + 1;
                end else begin
                    one_count = 0;
                    next_state = S2;
                end
                if (one_count == 6) next_state = S7;
            end
            S2: begin
                if (in) begin
                    next_state = S3;
                end else begin
                    next_state = S0;
                end
                one_count = (in) ? 1 : 0;
            end
            S3: begin
                if (in) begin
                    next_state = S4;
                end else begin
                    next_state = S0;
                end
                one_count = (in) ? one_count + 1 : 0;
            end
            S4: begin
                if (in) begin
                    next_state = S5;
                end else begin
                    next_state = S0;
                end
                one_count = (in) ? one_count + 1 : 0;
            end
            S5: begin
                if (in) begin
                    next_state = S6;
                end else begin
                    next_state = S0;
                end
                one_count = (in) ? one_count + 1 : 0;
            end
            S6: begin
                if (in) begin
                    disc = 1'b1;
                    next_state = S0;
                end else begin
                    next_state = F;
                end
                one_count = 0;
            end
            F: begin
                flag = 1'b1;
                next_state = S0;
            end
            S7: begin
                err = 1'b1;
                next_state = S0;
            end
        endcase
    end

endmodule
