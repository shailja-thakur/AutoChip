module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {LOW, MIDDLE, HIGH, ABOVE} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default all output signals to 0
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                if (s[1] == 1'b1) begin
                    next_state = MIDDLE;
                end
                else begin
                    next_state = LOW;
                end
            end
            MIDDLE: begin
                fr1 = 1;
                fr2 = 1;
                if (s[2] == 1'b1) begin
                    next_state = HIGH;
                end
                else if (s[1] == 1'b0) begin
                    next_state = LOW;
                end
                else begin
                    next_state = MIDDLE;
                end
            end
            HIGH: begin
                fr1 = 1;
                if (s[3] == 1'b1) begin
                    next_state = ABOVE;
                end
                else if (s[2] == 1'b0) begin
                    next_state = MIDDLE;
                end
                else begin
                    next_state = HIGH;
                end
            end
            ABOVE: begin
                if (s[3] == 1'b0) begin
                    if (s[2] == 1'b1) begin
                        dfr = 1;
                        next_state = HIGH;
                    end
                    else begin
                        next_state = MIDDLE;
                    end
                end
                else begin
                    next_state = ABOVE;
                end
            end
            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
