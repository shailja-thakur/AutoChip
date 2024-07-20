module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state;
reg [1:0] prev_state;

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the state machine to initial state
        state <= ABOVE_S3;
        prev_state <= 2'b00;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            ABOVE_S3: begin
                if (s[3]) begin
                    state <= BETWEEN_S3_S2;
                end
            end
            
            BETWEEN_S3_S2: begin
                if (!s[3]) begin
                    state <= BETWEEN_S2_S1;
                end else if (s[2]) begin
                    state <= ABOVE_S3;
                end
            end
            
            BETWEEN_S2_S1: begin
                if (!s[2]) begin
                    state <= BELOW_S1;
                end else if (s[1]) begin
                    state <= ABOVE_S3;
                end
            end
            
            BELOW_S1: begin
                if (s[1]) begin
                    state <= ABOVE_S3;
                end
            end
        endcase
        
        case (prev_state)
            ABOVE_S3: begin
                {fr3, fr2, fr1, dfr} <= 4'b1110;
            end
            
            BETWEEN_S3_S2: begin
                {fr3, fr2, fr1, dfr} <= 4'b1101;
            end
            
            BETWEEN_S2_S1: begin
                {fr3, fr2, fr1, dfr} <= 4'b1100;
            end
            
            BELOW_S1: begin
                {fr3, fr2, fr1, dfr} <= 4'b1000;
            end
        endcase
        
        prev_state <= state;
    end
end

endmodule
