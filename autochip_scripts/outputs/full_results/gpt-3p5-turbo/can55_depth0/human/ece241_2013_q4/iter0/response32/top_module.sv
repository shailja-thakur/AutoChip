module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    
    reg [1:0] prev_state;
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            curr_state <= 2'b00; // Initializing to low water level state
        end else begin
            curr_state <= next_state;
        end
    end
    
    always @(*) begin
        case (s)
            3'b111:
                next_state = 2'b00; // Above s[3]
            3'b110:
                next_state = 2'b01; // Between s[3] and s[2]
            3'b100:
                next_state = 2'b10; // Between s[2] and s[1]
            default:
                next_state = 2'b11; // Below s[1]
        endcase
    end
    
    always @(curr_state) begin
        case (curr_state)
            2'b00: // Above s[3]
                begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
            2'b01: // Between s[3] and s[2]
                begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
            2'b10: // Between s[2] and s[1]
                begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 0;
                end
            2'b11: // Below s[1]
                begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
        endcase
    end
endmodule
