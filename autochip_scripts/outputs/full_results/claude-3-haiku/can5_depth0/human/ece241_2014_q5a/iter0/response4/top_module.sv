module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam [1:0] 
    STATE_INIT = 2'd0,
    STATE_CONVERT = 2'd1,
    STATE_DONE = 2'd2;

reg [1:0] state, next_state;
reg [7:0] result;
reg [3:0] count;

// State transition logic
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= STATE_INIT;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        STATE_INIT: begin
            if (~areset)
                next_state = STATE_CONVERT;
            else
                next_state = STATE_INIT;
        end
        STATE_CONVERT: begin
            if (count == 4'd8)
                next_state = STATE_DONE;
            else
                next_state = STATE_CONVERT;
        end
        STATE_DONE: begin
            if (areset)
                next_state = STATE_INIT;
            else
                next_state = STATE_DONE;
        end
        default:
            next_state = STATE_INIT;
    endcase
end

// Output logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        result <= 8'd0;
        count <= 4'd0;
        z <= 1'b0;
    end else begin
        case (state)
            STATE_INIT: begin
                result <= 8'd0;
                count <= 4'd0;
                z <= 1'b0;
            end
            STATE_CONVERT: begin
                result[7:1] <= result[6:0];
                result[0] <= x;
                count <= count + 4'd1;
                z <= ~result[7];
            end
            STATE_DONE: begin
                z <= ~result[7];
            end
            default: begin
                result <= 8'd0;
                count <= 4'd0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
