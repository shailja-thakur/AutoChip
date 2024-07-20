module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    typedef enum logic [1:0] {
        ST_0 = 2'b00,
        ST_1 = 2'b01,
        ST_2 = 2'b10,
        ST_3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= ST_1;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        if (train_valid) begin
            case (current_state)
                ST_0: if (train_taken) next_state = ST_1;
                ST_1: if (train_taken) next_state = ST_2;
                      else           next_state = ST_0;
                ST_2: if (train_taken) next_state = ST_3;
                      else           next_state = ST_1;
                ST_3: if (!train_taken) next_state = ST_2;
            endcase
        end
    end

    assign state = current_state;

endmodule
