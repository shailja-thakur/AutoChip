module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // FSM states
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // state and next state signals
    reg state, next_state;

    // combinational logic for determining the next state
    always @* begin
        if(state == A) begin
            if(j) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end else begin
            if(k) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
    end

    // clocked always block for updating the state
    always @(posedge clk) begin
        if(areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // output logic for indicating the current state
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
