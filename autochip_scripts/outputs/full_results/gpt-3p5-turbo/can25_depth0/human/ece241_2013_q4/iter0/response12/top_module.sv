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
reg [1:0] state;

// Define states
parameter IDLE = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        // Reset all outputs and state machine
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
        state <= IDLE;
        prev_s <= 3'b0;
    end else begin
        prev_s <= s;
        
        case (state)
            IDLE: begin
                if (s == 3'b111) begin
                    // Water level is above s[3]
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s == 3'b110) begin
                    // Water level is between s[3] and s[2]
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S2;
                end else if (s == 3'b100) begin
                    // Water level is between s[2] and s[1]
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S1;
                end else if (s == 3'b000) begin
                    // Water level is below s[1]
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S3;
                end
            end
            
            S1: begin
                if (s == 3'b110) begin
                    // Water level is between s[3] and s[2]
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S2;
                end else if (s == 3'b100) begin
                    // Water level is between s[2] and s[1]
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end else if (s == 3'b000) begin
                    // Water level is below s[1]
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                    state <= S3;
                end
            end
            
            S2: begin
                if (s == 3'b111) begin
                    // Water level is above s[3]
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                    state <= IDLE;
                end else if (s == 3'b100) begin
                    // Water level is between s[2] and s[1]
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S1;
                end else if (s == 3'b000) begin
                    // Water level is below s[1]
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S3;
                end
            end
            
            S3: begin
                if (s == 3'b111) begin
                    // Water level is above s[3]
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                    state <= IDLE;
                end else if (s == 3'b110) begin
                    // Water level is between s[3] and s[2]
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S2;
                end else if (s == 3'b100) begin
                    // Water level is between s[2] and s[1]
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= S1;
                end
            end
        endcase
    end
end

endmodule
