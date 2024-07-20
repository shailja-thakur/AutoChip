module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state, next_state;
wire [1:0] state_wire;
assign state_wire = state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // A state
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state_wire)
        2'b00: begin // A state
            if (x) begin
                next_state = 2'b01; // B state
                z = 1'b1;
            end else begin
                next_state = 2'b00; // A state
                z = 1'b0;
            end
        end
        2'b01: begin // B state
            if (x) begin
                next_state = 2'b00; // B state
                z = 1'b0;
            end else begin
                next_state = 2'b01; // B state
                z = 1'b1;
            end
        end
    endcase
end

endmodule
