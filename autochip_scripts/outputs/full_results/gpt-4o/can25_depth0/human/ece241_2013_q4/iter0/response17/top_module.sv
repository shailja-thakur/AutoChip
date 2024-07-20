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
    reg [1:0] prev_s;

    // State encoding:
    localparam LOW     = 2'b00;
    localparam MID_LOW = 2'b01;
    localparam MID_HIGH= 2'b10;
    localparam HIGH    = 2'b11;

    // Update state on the clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
            prev_s <= 2'b00;
        end else begin
            state <= next_state;
            prev_s <= {s[3], s[2]};
        end
    end

    // Determine next state
    always @(*) begin
        case (state)
            LOW: begin
                if (s[1])
                    next_state = MID_LOW;
                else
                    next_state = LOW;
            end
            MID_LOW: begin
                if (s[2])
                    next_state = MID_HIGH;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = MID_LOW;
            end
            MID_HIGH: begin
                if (s[3])
                    next_state = HIGH;
                else if (!s[2])
                    next_state = MID_LOW;
                else
                    next_state = MID_HIGH;
            end
            HIGH: begin
                if (!s[3])
                    next_state = MID_HIGH;
                else
                    next_state = HIGH;
            end
            default: next_state = LOW;
        endcase
    end

    // Output logic based on state and previous state
    always @(*) begin
        // Default output values
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        
        case (state)
            LOW: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            MID_LOW: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                if (prev_s < {s[3], s[2]})
                    dfr = 1'b1;
            end
            MID_HIGH: begin
                fr1 = 1'b1;
                if (prev_s < {s[3], s[2]})
                    dfr = 1'b1;
            end
            HIGH: begin
                // No flow rate when in HIGH state
            end
        endcase
    end

endmodule
