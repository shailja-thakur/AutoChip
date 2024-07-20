module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        ABOVE_HIGH = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all the outputs to initial state
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            // Default values
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;

            case (state) 
                LOW: begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    if (s != 3'b000) begin
                        next_state <= MID;
                    end else begin
                        next_state <= LOW;
                    end
                end
                MID: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    if (s == 3'b011 || s == 3'b010) begin
                        next_state <= HIGH;
                    end else if (s == 3'b001) begin
                        next_state <= MID;
                    end else if (s == 3'b000) begin
                        next_state <= LOW;
                    end else if (s[3] == 1) begin
                        next_state <= ABOVE_HIGH;
                    end
                end
                HIGH: begin
                    fr1 <= 1'b1;
                    if (s[3] == 1) begin
                        next_state <= ABOVE_HIGH;
                    end else if (s[2] == 1 && s[3] == 0) begin
                        next_state <= HIGH;
                    end else if (s[2:1] == 2'b00) begin
                        next_state <= MID;
                    end
                end
                ABOVE_HIGH: begin
                    if (s[3] == 1) begin
                        next_state <= ABOVE_HIGH;
                    end else begin
                        next_state <= MID;
                    end
                end
                default: begin
                    next_state <= LOW;
                end
            endcase
            
            // Determine 'dfr'
            if (state == MID && next_state == HIGH) begin
                dfr <= 1'b1;
            end else if (state == HIGH && next_state == ABOVE_HIGH) begin
                dfr <= 1'b0;
            end else if (state == HIGH && next_state == MID) begin
                dfr <= 1'b1; // Increase flow when water level drops from HIGH to MID
            end
        end
    end
endmodule
