module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID_LOW = 2'b01,
        MID_HIGH = 2'b10,
        HIGH = 2'b11
    } state_t;

    reg [3:0] current_state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            LOW: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
            end
            MID_LOW: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
            end
            MID_HIGH: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
            end
            HIGH: begin
                if (s == 3'b000)
                    next_state = LOW;
                else if (s == 3'b001)
                    next_state = MID_LOW;
                else if (s == 3'b011)
                    next_state = MID_HIGH;
                else if (s == 3'b111)
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= LOW;
        else
            current_state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        // Default values
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                dfr = 1'b1;
            end
            MID_LOW: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b0;
                dfr = (next_state == MID_HIGH) ? 1'b1 : 1'b0;
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                fr2 = 1'b0;
                fr3 = 1'b0;
                dfr = (next_state == HIGH) ? 1'b1 : 1'b0;
            end
            HIGH: begin
                fr1 = 1'b0;
                fr2 = 1'b0;
                fr3 = 1'b0;
                dfr = 1'b0;
            end
        endcase
    end

endmodule
