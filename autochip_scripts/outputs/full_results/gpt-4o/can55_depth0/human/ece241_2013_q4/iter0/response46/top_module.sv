module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    // State definitions
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID1 = 2'b01,
        MID2 = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @* begin
        case(state)
            LOW: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID1;
                else if (s == 3'b011)
                    next_state = MID2;
                else
                    next_state = HIGH;
            end
            MID1: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b011)
                    next_state = MID2;
                else
                    next_state = MID1;
            end
            MID2: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID1;
                else if (s == 3'b111)
                    next_state = HIGH;
                else
                    next_state = MID2;
            end
            HIGH: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID1;
                else if (s == 3'b011)
                    next_state = MID2;
                else
                    next_state = HIGH;
            end
        endcase
    end

    // Output logic
    always @* begin
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        
        case(state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 1;
            end
            MID1: begin
                fr2 = 1;
                fr1 = 1;
                if (next_state == MID2)
                    dfr = 1;
            end
            MID2: begin
                fr1 = 1;
                if (next_state == HIGH)
                    dfr = 1;
            end
            HIGH: begin
                // All outputs are zero
            end
        endcase
    end
endmodule
