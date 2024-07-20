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

parameter IDLE = 2'b00;
parameter ABOVE_SENSOR = 2'b01;
parameter BETWEEN_SENSORS = 2'b10;
parameter BELOW_SENSOR = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
    end else begin
        prev_s <= s;
        
        case (state)
            IDLE: begin
                if (s[3]) begin
                    state <= ABOVE_SENSOR;
                end else if (s[2]) begin
                    state <= BETWEEN_SENSORS;
                end else if (s[1]) begin
                    state <= BELOW_SENSOR;
                end
            end
            ABOVE_SENSOR: begin
                if (~s[3]) begin
                    state <= IDLE;
                end
            end
            BETWEEN_SENSORS: begin
                if (s[3]) begin
                    state <= ABOVE_SENSOR;
                end else if (~s[2]) begin
                    state <= IDLE;
                end
            end
            BELOW_SENSOR: begin
                if (s[1]) begin
                    state <= BELOW_SENSOR;
                end else if (~s[1]) begin
                    state <= IDLE;
                end
            end
        endcase
        
        case (state)
            IDLE: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            ABOVE_SENSOR: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            BETWEEN_SENSORS: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            BELOW_SENSOR: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        endcase
    end
end

endmodule
