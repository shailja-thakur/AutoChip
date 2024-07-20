module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] 
    STATE_0 = 3'b000,
    STATE_1 = 3'b001,
    STATE_2 = 3'b010,
    STATE_3 = 3'b011,
    STATE_4 = 3'b100,
    STATE_5 = 3'b101,
    STATE_6 = 3'b110,
    STATE_7 = 3'b111;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    
    case (state)
        STATE_0: begin
            if (in == 1'b1) begin
                next_state = STATE_1;
            end else begin
                next_state = STATE_0;
            end
        end
        STATE_1: begin
            if (in == 1'b1) begin
                next_state = STATE_2;
            end else begin
                next_state = STATE_0;
            end
        end
        STATE_2: begin
            if (in == 1'b1) begin
                next_state = STATE_3;
            end else begin
                next_state = STATE_0;
            end
        end
        STATE_3: begin
            if (in == 1'b1) begin
                next_state = STATE_4;
            end else begin
                next_state = STATE_0;
            end
        end
        STATE_4: begin
            if (in == 1'b1) begin
                next_state = STATE_5;
            end else begin
                next_state = STATE_0;
            end
        end
        STATE_5: begin
            if (in == 1'b0) begin
                next_state = STATE_0;
                disc = 1'b1;
            end else begin
                next_state = STATE_6;
            end
        end
        STATE_6: begin
            if (in == 1'b1) begin
                next_state = STATE_7;
                flag = 1'b1;
            end else begin
                next_state = STATE_0;
            end
        end
        STATE_7: begin
            if (in == 1'b1) begin
                next_state = STATE_7;
                err = 1'b1;
            end else begin
                next_state = STATE_0;
            end
        end
        default: begin
            next_state = STATE_0;
        end
    endcase
end

endmodule
