module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] current_state;
reg [1:0] previous_state;

parameter HIGH = 2'b00;
parameter MID_HIGH = 2'b01;
parameter MID_LOW = 2'b10;
parameter LOW = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= LOW;
        previous_state <= LOW;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (current_state)
            HIGH: begin
                if (s[3]) begin
                    current_state <= HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    current_state <= MID_HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    current_state <= MID_LOW;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else begin
                    current_state <= LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            MID_HIGH: begin
                if (s[3]) begin
                    current_state <= HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    current_state <= MID_HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    current_state <= MID_LOW;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else begin
                    current_state <= LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            MID_LOW: begin
                if (s[3]) begin
                    current_state <= HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    current_state <= MID_HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    current_state <= MID_LOW;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else begin
                    current_state <= LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
            LOW: begin
                if (s[3]) begin
                    current_state <= HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2]) begin
                    current_state <= MID_HIGH;
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    current_state <= MID_LOW;
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end else begin
                    current_state <= LOW;
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
            end
        endcase
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        previous_state <= LOW;
    end else begin
        previous_state <= current_state;
    end
end

endmodule
