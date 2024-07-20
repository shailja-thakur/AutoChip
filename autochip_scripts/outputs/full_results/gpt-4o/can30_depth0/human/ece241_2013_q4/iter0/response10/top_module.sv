module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [1:0] state, next_state;

    // State encoding
    localparam LOW = 2'b00;
    localparam MID = 2'b01;
    localparam HIGH = 2'b10;
    localparam MAX = 2'b11;

    // State machine
    always @(*) begin
        case (state)
            LOW: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID;
                else if (s == 3'b011)
                    next_state = HIGH;
                else
                    next_state = MAX;
            end
            MID: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID;
                else if (s == 3'b011)
                    next_state = HIGH;
                else
                    next_state = MAX;
            end
            HIGH: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID;
                else if (s == 3'b011)
                    next_state = HIGH;
                else
                    next_state = MAX;
            end
            MAX: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID;
                else if (s == 3'b011)
                    next_state = HIGH;
                else
                    next_state = MAX;
            end
            default: next_state = LOW;
        endcase
    end

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
            MID: begin
                fr2 = 1;
                fr1 = 1;
                dfr = (next_state == HIGH) ? 1 : 0;
            end
            HIGH: begin
                fr1 = 1;
                dfr = (next_state == MAX) ? 1 : 0;
            end
            MAX: begin
                // All outputs remain 0
            end
            default: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
        endcase
    end

endmodule
