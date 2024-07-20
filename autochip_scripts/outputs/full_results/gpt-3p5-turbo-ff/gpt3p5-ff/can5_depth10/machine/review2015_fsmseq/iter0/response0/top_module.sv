module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // initial state S
    end else begin
        state <= next_state;
    end
end

always @* begin
    case(state)
        2'b00: begin // state S
            if (data) begin
                next_state = 2'b01; // next state S1
            end else begin
                next_state = 2'b00; // next state S
            end
        end
        2'b01: begin // state S1
            if (data) begin
                next_state = 2'b11; // next state S11
            end else begin
                next_state = 2'b00; // next state S
            end
        end
        2'b11: begin // state S11
            if (data) begin
                next_state = 2'b11; // next state S11
            end else begin
                next_state = 2'b10; // next state S110
            end
        end
        2'b10: begin // state S110
            if (data) begin
                next_state = 2'b10; // next state Done
            end else begin
                next_state = 2'b00; // next state S
            end
        end
        default: begin // Done state
            next_state = state; // next state remains Done
        end
    endcase
end

assign start_shifting = (state == 2'b10); // output high if state is Done, low otherwise

endmodule
