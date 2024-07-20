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
parameter [1:0] 
    LOW = 2'b00,
    MID = 2'b01, 
    HIGH = 2'b10,
    ABOVE = 2'b11;

always @(posedge clk) begin
    if (reset)
        state <= LOW;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        LOW: begin
            if (s[1] && s[2] && s[3])
                next_state = ABOVE;
            else if (s[1] && s[2])
                next_state = MID;
            else if (!s[1])
                next_state = LOW;
        end
        MID: begin
            if (s[1] && s[2] && s[3])
                next_state = ABOVE;
            else if (!s[2])
                next_state = LOW;
            else if (s[3])
                next_state = HIGH;
        end
        HIGH: begin
            if (s[1] && s[2] && s[3])
                next_state = ABOVE;
            else if (!s[3])
                next_state = MID;
        end
        ABOVE: begin
            if (!s[3])
                next_state = HIGH;
        end
    endcase
end

always @(*) begin
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;
    case (state)
        LOW: begin
            fr3 = 1;
            fr2 = 1;
            fr1 = 1;
        end
        MID: begin
            fr1 = 1;
            if (state != next_state)
                dfr = 1;
        end
        HIGH: begin
            if (state != next_state)
                dfr = 1;
        end
    endcase
end

endmodule
