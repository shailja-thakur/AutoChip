module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [3:0] state, state_next;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= 4'b0;
    end else begin
        state <= state_next;
    end
end

always @(state or x) begin
    case (state)
        4'b0001:
            if (x == 1'b1)
                state_next = 4'b0010;
            else
                state_next = 4'b0001;
        
        4'b0010:
            if (x == 1'b0)
                state_next = 4'b0001;
            else
                state_next = 4'b0010;
        
        default:
            state_next = state;
    endcase
end

always @(state) begin
    case (state)
        4'b0001, 4'b0010:
            z = 1'b0;
        
        4'b0011:
            z = x;
        
        default:
            z = 1'b0;
    endcase
end

endmodule
