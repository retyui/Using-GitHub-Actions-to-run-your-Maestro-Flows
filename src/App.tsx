import React from 'react';
import {Button, Text, StyleSheet, SafeAreaView} from 'react-native';

function App(): React.JSX.Element {
  const [count, setCount] = React.useState(0);

  const increment = (): void => setCount(c => c + 1);
  const decrement = (): void => setCount(c => c - 1);

  return (
    <SafeAreaView style={styles.root}>
      <Text testID="result_text" style={styles.text}>
        Count: {count}
      </Text>
      <Button testID="increment_btn" title="Increment" onPress={increment} />
      <Button testID="decrement_btn" title="Decrement" onPress={decrement} />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  root: {
    flex: 1,
    justifyContent: 'center',
    padding: 16,
  },
  text: {
    color: 'black',
    textAlign: 'center',
    fontSize: 24,
    marginBottom: 16,
  },
});

export default App;
