module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [3:0] {
        IDLE = 4'b0000,
        S0 = 4'b0001,
        S1 = 4'b0010,
        S2 = 4'b0011,
        S3 = 4'b0100,
        S4 = 4'b0101,
        S5 = 4'b0110,
        S6 = 4'b0111,
        DISC = 4'b1000,
        FLAG = 4'b1001,
        ERR = 4'b1010
    } state_t;
    
    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= (next_state == DISC);
            flag <= (next_state == FLAG);
            err <= (next_state == ERR);
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S1;
            end
            S0: begin
                if (in) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = DISC;
            end
            S6: begin
                if (in) next_state = ERR;
                else next_state = FLAG;
            end
            DISC: begin
                next_state = IDLE;
            end
            FLAG: begin
                next_state = IDLE;
            end
            ERR: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
