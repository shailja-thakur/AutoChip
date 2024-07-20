module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if(!aresetn) begin
        state <= 'b00; // State S
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        'b00: // State S
            if(x == 1'b0)
                next_state = 'b00;
            else
                next_state = 'b01;
        'b01: // State S1
            if(x == 1'b0)
                next_state = 'b10;
            else
                next_state = 'b01;
        'b10: // State S10
            if(x == 1'b0)
                next_state = 'b00;
            else
                next_state = 'b01;
        default:
            next_state = 'b00;
    endcase
end

always @(*) begin
    case(state)
        'b00: // State S
            z = 1'b0;
        'b01: // State S1
            z = 1'b0;
        'b10: // State S10
            z = x;
        default:
            z = 1'b0;
    endcase
end

endmodule
