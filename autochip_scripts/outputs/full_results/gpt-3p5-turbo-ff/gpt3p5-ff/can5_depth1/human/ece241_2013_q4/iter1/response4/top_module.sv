module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] prev_s;
reg [2:0] state;

parameter RESET_STATE = 3'b000;
parameter ABOVE_S3_STATE = 3'b001;
parameter BETWEEN_S3_S2_STATE = 3'b010;
parameter BETWEEN_S2_S1_STATE = 3'b011;
parameter BELOW_S1_STATE = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
        prev_s <= 3'b0;
        state <= RESET_STATE;
    end else begin
        prev_s <= s;
        
        case (state)
            RESET_STATE: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                
                if (s == 3'b000) begin // Below s[1]
                    state <= BELOW_S1_STATE;
                end else if (s[1:2] == 2'b11) begin // Above s[3]
                    state <= ABOVE_S3_STATE;
                end else if (s[2] == 1'b1) begin // Between s[3] and s[2]
                    state <= BETWEEN_S3_S2_STATE;
                end else begin // Between s[2] and s[1]
                    state <= BETWEEN_S2_S1_STATE;
                end
            end
            
            ABOVE_S3_STATE: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                
                if (s[1:2] != 2'b11) begin // Sensor change
                    if (s[1] == 1'b1) begin // Between s[3] and s[2]
                        state <= BETWEEN_S3_S2_STATE;
                    end else begin // Between s[2] and s[1]
                        state <= BETWEEN_S2_S1_STATE;
                    end
                end
            end
            
            BETWEEN_S3_S2_STATE: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                
                if (s[2] != 1'b1) begin // Sensor change
                    if (s[1] == 1'b1) begin // Between s[2] and s[1]
                        state <= BETWEEN_S2_S1_STATE;
                    end else begin // Below s[1]
                        state <= BELOW_S1_STATE;
                    end
                end
            end 
            
            BETWEEN_S2_S1_STATE: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= prev_s[1] > s[1];
                
                if (s[1] != 1'b1) begin // Sensor change
                    state <= BELOW_S1_STATE;
                end
            end
            
            BELOW_S1_STATE: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                
                if (s != 3'b000) begin // Sensor change
                    if (s[1:2] == 2'b11) begin // Above s[3]
                        state <= ABOVE_S3_STATE;
                    end else if (s[2] == 1'b1) begin // Between s[3] and s[2]
                        state <= BETWEEN_S3_S2_STATE;
                    end else begin // Between s[2] and s[1]
                        state <= BETWEEN_S2_S1_STATE;
                    end
                end
            end
            
        endcase
    end
end

endmodule
